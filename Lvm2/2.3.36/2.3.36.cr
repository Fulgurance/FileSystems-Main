class Target < ISM::Software

    def configure
        super

        configureSource(arguments:  "--prefix=/usr      \
                                    --enable-cmdlib     \
                                    --enable-pkgconfig  \
                                    --enable-udev_sync",
                        path:       buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)

        if option("Openrc")
            prepareOpenrcServiceInstallation(   path:   "#{workDirectoryPath}/Device-Mapper-Init.d",
                                                name:   "device-mapper")

            prepareOpenrcServiceInstallation(   path:   "#{workDirectoryPath}/Dmeventd-Init.d",
                                                name:   "dmeventd")

            prepareOpenrcServiceInstallation(   path:   "#{workDirectoryPath}/Lvm-Monitoring-Init.d",
                                                name:   "lvm-monitoring")

            prepareOpenrcServiceInstallation(   path:   "#{workDirectoryPath}/Lvm-Init.d",
                                                name:   "lvm")

            prepareOpenrcServiceInstallation(   path:   "#{workDirectoryPath}/Lvmlockd-Init.d",
                                                name:   "lvmlockd")

            prepareOpenrcServiceInstallation(   path:   "#{workDirectoryPath}/Lvmpolld-Init.d",
                                                name:   "lvmpolld")

            deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib/udev/rules.d/69-dm-lvm.rules")
        end
    end

    def deploy
        if autoDeployServices
            if option("Openrc")
                runRcUpdateCommand("add lvm default")
            end
        end
    end

end
