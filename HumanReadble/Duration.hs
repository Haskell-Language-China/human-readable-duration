-----------------------------------------------------------------------------
-- |
-- Module      :  HumanReadable.Duration
-- Copyright   :  (c) @murakami 2022
-- License     :  MIT-style (see the file LICENSE)
--
-- Maintainer  :  murakami
-- Stability   :  experimental
-- Portability :  portable
--
-- A Haskell Code that formats a duration, given as a number of seconds, in a human-friendly way.
-- 
-- usage
-- durationHumanReadable 12 -> Just "142 days, 21 hours, 21 minutes and 18 seconds"
-- show (read "12345678" :: Duration) -> “142 days, 21 hours, 21 minutes and 18 seconds”
-----------------------------------------------------------------------------

module HumanReadable.Duration
  (
    durationHumanReadable
  , Duration
  ) where

import Data.Maybe ( catMaybes )

durationHumanReadable :: Int -> Maybe String
durationHumanReadable n = if n < 0 then Nothing else Just . (show :: Duration -> String) . read . show $ n

data Duration = Duration { year :: Int
                         , day :: Int
                         , hour :: Int
                         , minute :: Int
                         , second :: Int } deriving (Eq, Ord)

instance Read Duration where
  readsPrec _ s = [(toEnum . read $ s, "")]

instance Show Duration where
  show Duration { year = y
                , day = d
                , hour = h
                , minute = m
                , second = s } = durationUnitsStringify . catMaybes $ zipWith maybeDurationUnit [ y, d, h, m, s ] units
    where units :: [String]
          units = [ "year", "day", "hour", "minute", "second" ]

          maybeDurationUnit :: Int -> String -> Maybe String
          maybeDurationUnit 0 _ = Nothing
          maybeDurationUnit 1 unit = Just $ "1 " <> unit
          maybeDurationUnit n unit = Just $ show n <> " " <> unit <> "s"

          durationUnitsStringify :: [String] -> String
          durationUnitsStringify [] = "0 seconds"
          durationUnitsStringify [x] = x
          durationUnitsStringify [x, y] = x <> " and " <> y
          durationUnitsStringify (x:xs) = x <> ", " <> durationUnitsStringify xs

instance Enum Duration where
  fromEnum Duration { year = y
                    , day = d
                    , hour = h
                    , minute = m
                    , second = s } = countMinuteOfSecond * ( countHourOfMinute * ( countDayOfHour * ( countYearOfDay * y + d ) + h ) + m ) + s
  
  toEnum n = Duration { year = y
                      , day = d
                      , hour = h
                      , minute = m
                      , second = s }
    where (ms, s) = n `divMod` 60
          (hs, m) = ms `divMod` 60
          (ds, h) = hs `divMod` 24
          (y, d) = ds `divMod` 365 

countYearOfDay :: Int
countYearOfDay = 365

countDayOfHour :: Int
countDayOfHour = 24

countHourOfMinute :: Int
countHourOfMinute = 60

countMinuteOfSecond ::Int
countMinuteOfSecond = 60
