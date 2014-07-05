# Introducing the Serialport_gps gem

Defaults:

* port: /dev/ttyAMA0
* baud_rate: 96000
* refresh_rate: 8 seconds

    require 'serialport_gps'

    gps = SerialPortGPS.new
    gps.start

Output:

<pre>
{:time=&gt;2014-07-05 21:53:40 +0000, :latitude=&gt;55.92721483, :longitude=&gt;-3.13518783}
{:time=&gt;2014-07-05 21:53:44 +0000, :latitude=&gt;55.92720717, :longitude=&gt;-3.13513767}
{:time=&gt;2014-07-05 21:53:52 +0000, :latitude=&gt;55.92721417, :longitude=&gt;-3.135116}
{:time=&gt;2014-07-05 21:54:00 +0000, :latitude=&gt;55.92722817, :longitude=&gt;-3.13505783}
{:time=&gt;2014-07-05 21:54:08 +0000, :latitude=&gt;55.92722067, :longitude=&gt;-3.1469765}
{:time=&gt;2014-07-05 21:54:16 +0000, :latitude=&gt;55.92720633, :longitude=&gt;-3.13509533}
{:time=&gt;2014-07-05 21:54:24 +0000, :latitude=&gt;55.92720567, :longitude=&gt;-3.1350735}
{:time=&gt;2014-07-05 21:54:32 +0000, :latitude=&gt;55.92721317, :longitude=&gt;-3.13508183}
</pre>

There is a callback proc which can be passed in at initialization which is triggered when new GPS data has arrived. The default callback which can be seen from the output above is used for testing purposes, as well as demonstrating what the gem outputs.

## Resources

* [Introducing the NMEA parser gem](http://www.jamesrobertson.eu/snippets/2014/jul/05/introducing-the-nmea-parser-gem.html)
* [jrobertson/serialport_gps](https://github.com/jrobertson/serialport_gps)

gps serialport gem
