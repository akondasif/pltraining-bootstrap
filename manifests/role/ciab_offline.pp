class bootstrap::profile::ciab_offline {
  if str2bool($::offline) {
    include bootstrap::profile::create_ap
  }
}
