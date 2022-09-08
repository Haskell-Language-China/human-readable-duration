# human-readable-duration
A Haskell Code that formats a duration, given as a number of seconds, in a human-friendly way.

## Usage

The Repo has one module,  `HumanReadable.Duration`, import it anywhere and use it's export function `durationHumanReadable` or export ADT `Duration`.

- durationHumanReadable :: Int -> Maybe String
- Duration :: see source
```hs
import HumanReadable.Duration ( durationHumanReadable
                              , Duration )

 
a :: Maybe String
a = durationHumanReadable 12345678

b :: String
b = show (read "12345678" :: Duration)
```
## Demo
![Jietu20220908-192043@2x](https://user-images.githubusercontent.com/28294081/189110272-ec56113a-3409-41a8-a5a3-2723580fcd53.jpeg)

Have fun!🙂
