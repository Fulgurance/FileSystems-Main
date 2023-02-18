class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--enable-compat-symlinks",
                            "--mandir=/usr/share/man",
                            "--docdir=/usr/share/doc/dosfstools-4.2"],
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
