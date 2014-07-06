#!/usr/bin/env ruby

# file: serialport_gps.rb

require 'nmea_parser'
require 'run_every'
require 'serialport'

class SerialPortGPS

  attr_reader :time, :latitude, :longitude, :to_h

  def initialize(port: "/dev/ttyAMA0", baud_rate: 9600, 
                refresh_rate: 8, callback: Proc.new {puts self.to_h.inspect})


    # if the refresh rate is any less than 8 seconds the serial connection
    # will have a higher probability of containing corrupted data

    refresh_rate = 8 if refresh_rate < 8
    @refresh_rate = refresh_rate - 4
    @callback = callback

    #params for serial port    
    @port = port
    @baud_rate = baud_rate
    @data_bits = 8
    @stop_bits = 1
    @parity = SerialPort::NONE

    @np = NMEAParser.new
  end

  def start

    @running = true
    #sp = @sp

    RunEvery.new(seconds: @refresh_rate) do 

      Thread.stop unless @running

      begin

        sp = SerialPort.new(@port, @baud_rate, @data_bits, @stop_bits, @parity)
        sleep 4
        s = ''

        (s = sp.gets; @np.parse(s.scrub)) until s =~ /^\$GPGGA/

      rescue
        puts 'warning: ' +($!).inspect
        retry
      end

      sp.close

      @time, @latitude, @longitude = @np.time, @np.latitude, @np.longitude
      @to_h = @np.to_h
      @callback.call
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
