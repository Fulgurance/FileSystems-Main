class Target < ISM::Software

    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--bindir=/usr/sbin",
                            "--sysconfdir=/etc",
                            "--enable-manpages",
                            "--disable-static"],
                            buildDirectoryPath)
    end

    def build
        super

        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        if option("Openrc")
            makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d")
            moveFile("#{workDirectoryPath(false)}udev-postmount","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d/udev")
            runChmodCommand(["+x","elogind"],"#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d")
        end
    end

    def install
        super

        runUdevadmCommand(["hwdb","--update"])
    end

end
