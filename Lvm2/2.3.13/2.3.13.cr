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
            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/device-mapper.rc-2.02.105-r2","device-mapper")

            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/dmeventd.initd-2.02.184-r2","dmeventd")

            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/lvm-monitoring.initd-2.02.105-r2","lvm-monitoring")

            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/lvm.rc-2.02.187","lvm")

            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/lvmlockd.initd-2.02.166-r1","lvmlockd")

            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/lvmpolld.initd-2.02.183","lvmpolld")
        end
    end

end
