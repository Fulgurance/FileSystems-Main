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

        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
