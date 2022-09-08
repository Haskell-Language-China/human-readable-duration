-----------------------------------------------------------------------------
-- |
-- Module      :  Test
-- Copyright   :  (c) @murakami 2022
-- License     :  MIT-style (see the file LICENSE)
--
-- Maintainer  :  murakami
-- Stability   :  stable
-- Portability :  no
--
-- Just a test for HumanReadable.Duration module.
-----------------------------------------------------------------------------

module Test
  (
    test
  ) where

import HumanReadable.Duration ( durationHumanReadable
                              , Duration )

test :: IO ()
test = do
  putStrLn "｡◝‿◜｡ do something for durationHumanReadable ｡◝‿◜｡"
  print $ durationHumanReadable 12345678
  putStrLn "｡◝‿◜｡ do something for Duration read ｡◝‿◜｡"
  print $ (read "12345678" :: Duration)  
