{-# LANGUAGE FlexibleContexts #-}

module Control.Concurrent.MSem.Lifted (
    new
  , peekAvail
  , signal
  , wait
  , with
  ) where

import Control.Concurrent.MSem(MSem)
import qualified Control.Concurrent.MSem as M
import Control.Monad.Trans
import Control.Monad.Trans.Control

new :: (Integral i, MonadIO m) => i -> m (MSem i)
new = liftIO . M.new

with :: (Integral i, MonadBaseControl IO m) => MSem i -> m a -> m a
with = liftBaseOp_ . M.with

wait :: (Integral i, MonadIO m) => MSem i -> m ()
wait = liftIO . M.wait

signal :: (Integral i, MonadIO m) => MSem i -> m ()
signal = liftIO . M.signal

peekAvail :: (Integral i, MonadIO m) => MSem i -> m i
peekAvail = liftIO . M.peekAvail
