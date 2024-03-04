{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./cli ./applications];
}
