import Spellbook.Internals

main :: IO ()
main = getParentProcessArgs >>= print
