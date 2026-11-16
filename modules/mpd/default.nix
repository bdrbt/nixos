{ config, pkgs, ... }:

let
  username = "bdrbt";
  homeDir = "/home/${username}";
  musicDir = "${homeDir}/media/music";
  mpdDir = "${homeDir}/.config/mpd";
in
{

  environment.systemPackages = [
    (pkgs.ncmpcpp.override {
      visualizerSupport = true;
    })
  ];

  hjem.users.${username} = {
    enable = true;

    files.".config/mpd/mpd.conf".text = ''
      music_directory     "${musicDir}"
      playlist_directory  "${mpdDir}/playlists"
      db_file             "${mpdDir}/database"
      log_file            "${mpdDir}/log"
      pid_file            "${mpdDir}/pid"
      state_file          "${mpdDir}/state"

      # Вывод звука через пользовательский PipeWire
      audio_output {
          type "pipewire"
          name "PipeWire Output"
      }
    '';

    files.".ncmpcpp/config".text = ''
      mpd_host = "127.0.0.1"
      mpd_port = "6600"
      mpd_music_dir = "${musicDir}"

      # Настройки визуализатора звука
      visualizer_data_source = "/tmp/mpd.fifo"
      visualizer_output_name = "Visualizer FIFO"
      visualizer_in_stereo = "yes"
      visualizer_type = "spectrum"
      visualizer_look = "◆▋"

      # Внешний вид и поведение
      colors_enabled = "yes"
      enable_window_title = "yes"
      statusbar_visibility = "yes"
      header_visibility = "yes"
      cyclic_scrolling = "yes"
      mouse_support = "yes"
    '';

  };

  users.users.${username}.linger = true;

  # 3. Пользовательский сервис systemd для запуска MPD
  systemd.user.services.mpd = {
    enable = true;
    description = "Music Player Daemon (User)";
    after = [
      "network.target"
      "sound.target"
      "pipewire.service"
    ];
    wantedBy = [ "default.target" ];

    # Применяем сервис строго для указанного пользователя
    unitConfig.ConditionUser = username;

    serviceConfig = {
      # Автоматически создаем папку для плейлистов перед стартом
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${mpdDir}/playlists";
      ExecStart = "${pkgs.mpd}/bin/mpd --no-daemon";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
