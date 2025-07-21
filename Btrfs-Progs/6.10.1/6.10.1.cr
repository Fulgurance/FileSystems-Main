class Target < ISM::Software

    def prepare
        super

        runAutoreconfCommand(   arguments: "-fiv",
                                path: buildDirectoryPath)
    end

    def configure
        super

        usingGlibc = component("C-Library").uniqueDependencyIsEnabled("Glibc")

        backtrace = (usingGlibc ? "--enable-backtrace" : "--disable-backtrace")

        configureSource(arguments:  "--prefix=/usr              \
                                    --disable-static            \
                                    --disable-documentation     \
                                    #{backtrace}",
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
    end

end
