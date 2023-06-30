{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
    pname = "teller";
    version = "1.5.6";
    vendorSha256 = null;

    src = fetchFromGitHub {
        owner = "tellerops";
        repo = "teller";
        rev = "v${version}";
        sha256="sha256-vgrfWKKXf4C4qkbGiB3ndtJy1VyTx2NJs2QiOSFFZkE=";
    };

    meta = with lib; {
        description = "Cloud native secrets management for developers - never leave your command line for secrets.";
        homepage = "https://tlr.dev";
        license = licenses.asl20;
    };
}