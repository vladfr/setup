{ lib, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "wasme";
  version = "v0.0.33";

  src = fetchFromGitHub {
    owner = "solo-io";
    repo = "wasm";
    rev = version;
    sha256 = "sha256-hHEjj8sVQERZc5oiFzI9HTDYesrNdIZ6GyJro8VFwls=";
  };
  vendorHash = "sha256-RSpYu2hz0uaHKq/oJHP+MY1hNiMezxuW/MZa4SNH6Ms=";

  nativeBuildInputs = [ installShellFiles ];

  # Bundle release metadata
  ldflags = let
    attrs = [
      "version.buildVersion=${version}"
      "version.buildStatus=Nix"
    ];
  in ["-s" "-w" "${lib.concatMapStringsSep " " (attr: "-X ${attr}") attrs}"];

  modRoot = "tools/wasme/cli" ;

  unpackPhase = ''
    ls -al ./
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    $out/bin/wasme --version | grep ${version} > /dev/null
  '';

  postInstall = ''

  '';

  meta = with lib; {
    description = "";
    homepage = "https://docs.solo.io/web-assembly-hub/";
    license = licenses.asl20;
    maintainers = with maintainers; [ bryanasdev000 veehaitch ];
  };
}