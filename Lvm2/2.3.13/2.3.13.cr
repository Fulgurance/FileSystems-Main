class Target < ISM::Software

    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--enable-cmdlib",
                            "--enable-pkgconfig",
                            "--enable-udev_sync"],
                            buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        if option("Openrc")
            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/Device-Mapper-Init.d","device-mapper")

            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/Dmeventd-Init.d","dmeventd")

            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/Lvm-Monitoring-Init.d","lvm-monitoring")

            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/Lvm-Init.d","lvm")

            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/Lvmlockd-Init.d","lvmlockd")

            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/Lvmpolld-Init.d","lvmpolld")
        end
    end

end
