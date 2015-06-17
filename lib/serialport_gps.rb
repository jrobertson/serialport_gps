#!/usr/bin/env ruby

# file: serialport_gps.rb

require 'nmea_parser'
require 'run_every'
require 'serialport'


class SerialPortGPS

  attr_reader :time, :latitude, :longitude, :to_h

  def initialize(port: "/dev/ttyAMA0", baud_rate: 9600, 
                refresh_rate: 8, callback: ->(gps){ puts gps.to_h.inspect})


    # if the refresh rate is any less than 8 seconds the serial connection
    # will have a higher probability of containing corrupted data

    refresh_rate ||= 8
    refresh_rate = 8 if refresh_rate < 8
    @refresh_rate = refresh_rate - 4
    @callback = callback

    #params for serial port    
    @port, @baud_rate, @data_bits, @stop_bits, @parity = port, baud_rate, 
                                                         8, 1, SerialPort::NONE
    @np = NMEAParser.new
  end

  def start

    @running = true

    RunEvery.new(seconds: @refresh_rate, thread_name: 'GPS listener') do 

      Thread.stop unless @running

      begin

        sp = SerialPort.new(@port, @baud_rate, @data_bits, @stop_bits, @parity)
        sleep 4
        s = ''

        (s = sp.gets.scrub; @np.parse(s)) until s =~ /^\$GPGGA/
        sp.close

      rescue
        puts 'warning: ' + ($!).inspect
        retry
      end

      @time, @latitude, @longitude, @to_h = @np.time, @np.latitude, 
                                                        @np.longitude, @np.to_h
      @callback.call @np.to_struct
    end
  end

  def stop()
    @running = false
  end

end

if __FILE__ == $0 then

  gps = SerialPortGPS.new
  gps.start
end