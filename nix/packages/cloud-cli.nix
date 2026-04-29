{ config, unstable, ... }:
{
    config = {
        home.packages = with unstable; [
            #civo
            #upbound
            vault
            #natscli
            (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
            awscli2
            # opentofu
            # red hat
            # rosa
            ocm
            rhoas
            odo
            jq
            scaleway-cli
            glab
        ];
    };
}
