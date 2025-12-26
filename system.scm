(use-modules (gnu bootloader)
             (gnu bootloader grub)
             (gnu services desktop)
             (gnu services nix)
             (gnu system file-systems))

(operating-system
 (host-name "guix-vm")
 (timezone "Etc/UTC")
 (locale "en_US.utf8")
 (bootloader (bootloader-configuration
              (bootloader grub-bootloader)
              (targets '("null"))))
 (file-systems %base-file-systems)
 (services (cons* (service gnome-desktop-service-type)
                  (service nix-service-type
                           (nix-configuration
                            (extra-config
                             '("experimental-features = nix-command flakes"))))
                  %desktop-services))
 (users (cons* (user-account
                (name "bob")
                (comment "Bob")
                (group "users")
                (home-directory "/home/bob")
                (password (crypt "123" "$6$abc"))
                (supplementary-groups '("audio"
                                        "video"
                                        "wheel")))
               %base-user-accounts)))
