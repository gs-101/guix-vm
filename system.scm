(use-modules (gnu bootloader)
             (gnu bootloader grub)
             (gnu packages terminals)
             (gnu packages wm)
             (gnu services desktop)
             (gnu services sddm)
             (gnu services xorg)
             (gnu system file-systems))

(operating-system
 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets '("/boot/efi"))))
 (file-systems (cons* (file-system
                       (device (file-system-label "root"))
                       (mount-point "/")
                       (type "ext4"))
                      (file-system
                       (device (file-system-label "boot-efi"))
                       (mount-point "/boot/efi")
                       (type "vfat"))
                      %base-file-systems))
 (host-name "guix-vm")
 (packages (cons* foot
                  sway
                  %base-packages))
 (services (cons* (service sddm-service-type
                           (sddm-configuration
                            (auto-login-user "bob")
                            (auto-login-session "sway.desktop")))
                  (modify-services %desktop-services
                                   (delete gdm-service-type))))
 (users (cons* (user-account
                (name "bob")
                (comment "Bob")
                (group "users")
                (supplementary-groups '("audio"
                                        "video"
                                        "wheel")))
               %base-user-accounts)))
