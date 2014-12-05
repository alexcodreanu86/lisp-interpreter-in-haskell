module Paths_interpreter (
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
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/alextsveta2012/Library/Haskell/bin"
libdir     = "/Users/alextsveta2012/Library/Haskell/ghc-7.8.3-x86_64/lib/interpreter-0.1.0.0"
datadir    = "/Users/alextsveta2012/Library/Haskell/share/ghc-7.8.3-x86_64/interpreter-0.1.0.0"
libexecdir = "/Users/alextsveta2012/Library/Haskell/libexec"
sysconfdir = "/Users/alextsveta2012/Library/Haskell/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "interpreter_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "interpreter_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "interpreter_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "interpreter_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "interpreter_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
