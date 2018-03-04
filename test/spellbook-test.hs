import Spellbook.Process

main :: IO ()
main = getParentProcessArgs >>= print
