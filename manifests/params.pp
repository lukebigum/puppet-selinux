# Class: selinux::params
#
# Description
#  This class provides default parameters for the selinux class
#
# Sample Usage:
#  mod_dir = $selinux::params::sx_mod_dir
#
class selinux::params {
  $sx_mod_dir   = '/usr/share/selinux'
  $mode         = 'disabled'

  case $::operatingsystem {
    /^(RedHat|CentOS)$/: {
      case $::operatingsystemmajrelease {
        '7': {
          $sx_fs_mount = '/sys/fs/selinux'
          $package_name = 'policycoreutils-python'
        }
        '6': {
          $sx_fs_mount = '/selinux'
          $package_name = 'policycoreutils-python'
        }
        '5': {
          $sx_fs_mount = '/selinux'
          $package_name = 'policycoreutils'
        }
        default: {
          fail("${::operatingsystem}-${::operatingsystemmajrelease} is not supported")
        }
      }
    }
    'Fedora': {
      case $::operatingsystemmajrelease {
        /^(21|22)$/: {
          $sx_fs_mount = '/sys/fs/selinux'
          $package_name = 'policycoreutils-python'
        }
        default: {
          fail("${::operatingsystem}-${::operatingsystemmajrelease} is not supported")
        }
      }
    }
    default: {
      fail("${::operatingsystem} is not supported")
    }
  }

  $restorecond_config_file       = '/etc/selinux/restorecond.conf'
  $restorecond_config_file_mode  = '0644'
  $restorecond_config_file_owner = 'root'
  $restorecond_config_file_group = 'root'

}
