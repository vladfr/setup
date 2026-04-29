{ config, unstable, ... }:
{
    config = {
        home.packages = with unstable; [
            supabase-cli
        ];
    };
}