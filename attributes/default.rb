# This is probably not ideal, as we are not targeting a specific
# version of Sysmon due to there not being an archive of versions
# at the canonical site or version-named files to download.
#
# You will get the latest and greatest via the URL below, but this
# is thought to be pretty safe as the tool is very mature by now
# and is largely in feature-addition and bug-fix mode. The application
# arguments are not likely to change and break your existing usage or
# this cookbook.
#
# Also, because of this, we cannot even verify the checksum of the
# file once downloaded, as "Sysmon.zip" could change at any time.

default['sysmon']['url'] = 'https://download.sysinternals.com/files/Sysmon.zip'

default['sysmon']['accepteula'] = true
