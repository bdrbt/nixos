{config,...}:
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    desktop = "${config.home.homeDirectory}/common/desktop";
    publicShare =  "${config.home.homeDirectory}/common/public";
    templates =  "${config.home.homeDirectory}/common/templates";
    music = "${config.home.homeDirectory}/media/audio";
    pictures = "${config.home.homeDirectory}/media/images";
    videos = "${config.home.homeDirectory}/media/videos";
  };
}
