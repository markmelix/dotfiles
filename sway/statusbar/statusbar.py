#!venv/bin/python3

from datetime import datetime
from psutil import disk_usage, sensors_battery
from psutil._common import bytes2human
from sys import stdout
from time import sleep
from pulsectl import Pulse, PulseVolumeInfo

def get_volume():
    with Pulse('get_volume') as pulse:
        return int(round(pulse.sink_list()[0].volume.value_flat, 2) * 100)

def is_mute():
    with Pulse('check-mute') as pulse:
        return bool(pulse.sink_list()[0].mute)


def refresh():
    usage = disk_usage('/')
    free = bytes2human(usage.free)
    used = bytes2human(usage.used)
    total = bytes2human(usage.total)
    percent = disk_usage('/').percent
    disk = f"{used} ({percent}%) of {total} / {free} free"

    battery_percent = int(sensors_battery().percent)

    battery_status = "^" if sensors_battery().power_plugged else ""

    volume = get_volume()

    mute = "M" if is_mute() else ""

    date = datetime.now().strftime('%h %d %A / %H:%M')


    stdout.write(f"{disk} / B{battery_percent}%{battery_status} / V{volume}%{mute} / {date}")
    stdout.flush()

while True:
    refresh()
    sleep(0.2)
