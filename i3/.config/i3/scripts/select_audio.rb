# frozen_string_literal: true

return if ARGV.size != 1

application_launcher = ARGV.first
device_regex = /.*name: <(.*)>\n.*device.description = "(.*)"/
sinks = `pacmd list-sinks | grep -e 'name:' -e 'device.description'`
devices = sinks.scan(device_regex).map(&:reverse).to_h
audio_device_choice = devices[`echo '#{devices.keys.join('\n')}' | #{application_launcher}`.chomp]
`pacmd set-default-sink #{audio_device_choice}` if audio_device_choice
