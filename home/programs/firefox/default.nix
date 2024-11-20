{ pkgs, config, ... }:
let
  accent = "#${config.lib.stylix.colors.base0D}";
  background = "#${config.lib.stylix.colors.base00}";
  foreground = "#${config.lib.stylix.colors.base05}";
  muted = "#${config.lib.stylix.colors.base03}";

  settings = ''
    {
      "config": {
        "title" : "Welcome Home",
        "openLinksInNewTab": false,
        "locale": "de-DE",
        "colors": {
          "primary": "${accent}",
          "background": "${background}",
          "foreground": "${foreground}",
          "muted": "#${muted}"
        },
        "folders": [
          {
            "name": "Bookmarks",
            "links": [
              {"title": "Github", "url": "https://github.com", "icon": ""},
              {"title": "Server", "url": "https://home.anotherhadi.com", "icon": ""}
            ]
          },
          {
            "name": "Work",
            "links": [
              {"title": "Outlook", "url": "https://outlook.office.com/mail/", "icon": "󰴢"},
              {"title": "Office", "url": "https://www.office.com/?auth=2", "icon": "󰏆"},
              {"title": "Teams", "url": "https://teams.microsoft.com/_", "icon": "󰊻"}
            ]
          }
        ]
      }
    }
  '';

in {
  stylix.targets.firefox.profileNames = [ "default" ];
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      "AutofillAddressEnabled" = false;
      "AutofillCreditCardEnabled" = false;
    };

    profiles."default" = {
      id = 0;
      isDefault = true;
      name = "default";
      settings = {
        "app.normandy.first_run" = false;

        "browser.bookmarks.addedImportButton" = false;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.warnOnQuitShortcut" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "signon.rememberSignons" = false;

        "browser.startup.homepage" = "${homepage}/build/index.html";
        "browser.search.region" = "FR";
        "browser.search.isUS" = false;
        "distribution.searchplugins.defaultLocale" = "fr-FR";
        "general.useragent.locale" = "fr-FR";
        "browser.bookmarks.showMobileBookmarks" = true;
        "browser.newtabpage.pinned" = [{
          title = "Homepage";
          url = "${homepage}/build/index.html";
        }];
      };
      bookmarks = [
        {
          name = "Homepage";
          url = "${homepage}/build/index.html";
        }
        {
          name = "wikipedia";
          tags = [ "wiki" ];
          keyword = "wiki";
          url =
            "https://en.wikipedia.org/wiki/Special:Search?search=%s&amp;go=Go";
        }
        {
          name = "kernel.org";
          url = "https://www.kernel.org";
        }
        {
          name = "Nix sites";
          toolbar = true;
          bookmarks = [
            {
              name = "homepage";
              url = "https://nixos.org/";
            }
            {
              name = "wiki";
              tags = [ "wiki" "nix" ];
              url = "https://wiki.nixos.org/";
            }
          ];
        }
      ];
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [ privacy-badger ];
      search = {
        order = [ "google" "duckduckgo" "wikipedia" ];
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];

            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [{
              template =
                "https://wiki.nixos.org/index.php?search={searchTerms}";
            }];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.alias =
            "@g"; # builtin engines only support specifying one additional alias
        };
        default = "DuckDuckGo";
      };
    };
    # profiles = {
    # default = {
    #   extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #     ublock-origin
    #     vimium
    #     sponsorblock
    #     youtube-recommended-videos
    #     scroll_anywhere
    #     newtab-adapter
    #     plasma-integration
    #   ];
    # };
  };
}
