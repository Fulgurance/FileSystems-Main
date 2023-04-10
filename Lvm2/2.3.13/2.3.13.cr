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
            makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d")
            moveFile("#{workDirectoryPath(false)}/device-mapper.rc-2.02.105-r2","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d/device-mapper")
            runChmodCommand(["+x","device-mapper"],"#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/init.d")

            makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d")
            moveFile("#{workDirectoryPath(false)}/dmeventd.initd-2.02.184-r2","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d/dmeventd")
            runChmodCommand(["+x","dmeventd"],"#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/init.d")

            makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d")
            moveFile("#{workDirectoryPath(false)}/lvm-monitoring.initd-2.02.105-r2","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d/lvm-monitoring")
            runChmodCommand(["+x","lvm-monitoring"],"#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/init.d")

            makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d")
            moveFile("#{workDirectoryPath(false)}/lvm.rc-2.02.187","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d/lvm")
            runChmodCommand(["+x","lvm"],"#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/init.d")

            makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d")
            moveFile("#{workDirectoryPath(false)}/lvmlockd.initd-2.02.166-r1","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d/lvmlockd")
            runChmodCommand(["+x","lvmlockd"],"#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/init.d")

            makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d")
            moveFile("#{workDirectoryPath(false)}/lvmpolld.initd-2.02.183","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d/lvmpolld")
            runChmodCommand(["+x","lvmpolld"],"#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/init.d")
        end
    end

end
