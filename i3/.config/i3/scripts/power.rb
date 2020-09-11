# frozen_string_literal: true

return if ARGV.size != 2

app_launcher, locker = ARGV

def lock_command(locker, lock_enabled)
  return '' unless lock_enabled

  "#{locker} && sleep .1 && "
end

def app_launcher_prompt(app_launcher, choices)
  `echo '#{choices.join('\n')}' | #{app_launcher}`.chomp
end

power_options = {
  'Sleep' => { power_action: 'suspend', lock: true },
  'Reboot' => { power_action: 'reboot' },
  'Shutdown' => { power_action: 'poweroff -i' }
}

power_choice = app_launcher_prompt(app_launcher, power_options.keys)

power_action, lock_enabled = power_options[power_choice]
                             &.values_at(:power_action, :lock)

return unless power_action

`#{lock_command(locker, lock_enabled)}systemctl #{power_action}`
