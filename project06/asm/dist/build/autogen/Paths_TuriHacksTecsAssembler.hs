module Paths_TuriHacksTecsAssembler (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/develop/haskell_tests/.cabal-sandbox/bin"
libdir     = "/develop/haskell_tests/.cabal-sandbox/lib/x86_64-linux-ghc-7.6.2/TuriHacksTecsAssembler-0.1.0.0"
datadir    = "/develop/haskell_tests/.cabal-sandbox/share/x86_64-linux-ghc-7.6.2/TuriHacksTecsAssembler-0.1.0.0"
libexecdir = "/develop/haskell_tests/.cabal-sandbox/libexec"
sysconfdir = "/develop/haskell_tests/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "TuriHacksTecsAssembler_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "TuriHacksTecsAssembler_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "TuriHacksTecsAssembler_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "TuriHacksTecsAssembler_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "TuriHacksTecsAssembler_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
