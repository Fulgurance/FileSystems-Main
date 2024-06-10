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
            prepareOpenrcServiceInstallation("#{workDirectoryPath}/Device-Mapper-Init.d","device-mapper")

            prepareOpenrcServiceInstallation("#{workDirectoryPath}/Dmeventd-Init.d","dmeventd")

            prepareOpenrcServiceInstallation("#{workDirectoryPath}/Lvm-Monitoring-Init.d","lvm-monitoring")

            prepareOpenrcServiceInstallation("#{workDirectoryPath}/Lvm-Init.d","lvm")

            prepareOpenrcServiceInstallation("#{workDirectoryPath}/Lvmlockd-Init.d","lvmlockd")

            prepareOpenrcServiceInstallation("#{workDirectoryPath}/Lvmpolld-Init.d","lvmpolld")

            deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib/udev/rules.d/69-dm-lvm.rules")
        end
    end

end
