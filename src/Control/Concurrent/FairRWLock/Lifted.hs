{-# LANGUAGE FlexibleContexts #-}
module Control.Concurrent.FairRWLock.Lifted (
    acquireRead
  , acquireWrite
  , checkLock
  , new
  , peekLock
  , releaseRead
  , releaseWrite
  , withRead
  , withWrite
) where

import Control.Concurrent.FairRWLock (RWLock,LockKind,RWLockException,FRW)
import qualified Control.Concurrent.FairRWLock as L
import Control.Monad.Trans
import Control.Monad.Trans.Control

new :: MonadIO m => m RWLock
new = liftIO $ L.new

withRead :: MonadBaseControl IO m => RWLock -> m a -> m a
withRead = liftBaseOp_ . L.withRead

withWrite :: MonadBaseControl IO m => RWLock -> m a -> m a
withWrite = liftBaseOp_ . L.withWrite

acquireRead :: MonadIO m => RWLock -> m ()
acquireRead = liftIO . L.acquireRead

acquireWrite :: MonadIO m => RWLock -> m ()
acquireWrite = liftIO . L.acquireWrite

releaseRead :: MonadIO m => RWLock -> m (Either RWLockException ())
releaseRead = liftIO . L.releaseRead

releaseWrite :: MonadIO m => RWLock -> m (Either RWLockException ())
releaseWrite = liftIO . L.releaseWrite

peekLock :: MonadIO m => RWLock -> m (FRW, [LockKind])
peekLock = liftIO . L.peekLock

checkLock :: MonadIO m => RWLock -> m (Int, Int)
checkLock = liftIO . L.checkLock
