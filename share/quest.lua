$file "quest.lua"
$line 1

--
-- $Id: quest.lua 3 2006-04-29 13:17:19Z lindig $
--
-- Important built-in code for Quest. This module must be loaded first.
--

R    = Rand -- abbreviation

Quest = {}
Quest.version = "$Id: quest.lua 3 2006-04-29 13:17:19Z lindig $"

-- cpp(1) macros emitted at the top of a file

Quest.header = [[
/*
 * This code is generated by Quest and is intended to find
 * inconsistencies in C compilers. To learn more about Quest, visit:
 *
 *      http://www.st.cs.uni-sb.de/~lindig/src/quest/
 */

/* These macros are defined in Lua string Quest.header, which may be
 * re-defined from the quest command line or in file quest.lua. 
 */
#ifndef QUEST_FAILED
#include <assert.h>
#define QUEST_ASSERT(x) assert(x)
#else
#define QUEST_ASSERT(x) if (!(x)) failed(__LINE__)
#endif
]]

-- interactive read, eval, print loop
function Quest.shell ()
    local prompt = "> "
    local stmt
    write ("-- ", Quest.version, "\n")
    write ("-- This is Lua-ML for Quest\n")
    
    write(prompt)
    stmt = read()
    while stmt ~= nil do
        dostring(stmt)
        write(prompt)
        stmt = read()
    end           
    exit()
end

-- open two files
function Quest.open2 (basename)
    local main   = format ("%s-main.c", basename)
    local client = format ("%s-callee.c", basename)
    return File.open_out(main), File.open_out(client)
end    

-- emit test cases for two compilation units
function Quest.stereo(options)
    local main, client = Quest.open2(options.out)
    local generator    = Test[options.gen].test ()
    if generator == nil then
        File.close_out(main); File.close_out(client)
        error("no such test case generator: " .. options.gen)
    end
    local tests = Test.generate (generator, options.n, options.size)
    File.write(main, format("/* %s */\n", Quest.version))
    File.write(main, format("/* %s */\n", CMD.argstr))
    File.write(main, Quest.header)
    File.write(client, format("/* %s */\n", Quest.version))
    File.write(client, Quest.header)
    Emit.stereo(main, client, tests)
    File.close_out(main); File.close_out(client)
end

-- emit test cases for one compilation unit
function Quest.mono(options)
    local generator = Test[options.gen].test ()
    if generator == nil then
        error("no such test case generator: " .. options.gen)
    end
    local tests     = Test.generate (generator, options.n, options.size)
    File.write(File.stdout, format("/* %s */\n", Quest.version))
    File.write(File.stdout, format("/* %s */\n", CMD.argstr))
    File.write(File.stdout, Quest.header)
    Emit.mono(File.stdout,tests)
end

--
function Quest.try(options,gen)
    local i = 0
    while i < options.n do
        i = i + 1
        local uniq = Uniq.make ()
        local t = R.run(gen, uniq, options.size)
        print(t)
    end
end    
--

function Quest.list_tests()
    local key, val = next(Test,nil)
    while key do
        if type(val) == "table" and val.doc ~= nil then
            write(format("%-10s%s\n", key, val.doc))
        end
        key, val = next(Test,key)
    end
end    

-- main routine, it is called from the OCaml module main.nw 
function Quest.main(options)
    if options.stereo then
        Quest.stereo(options)
    else
        Quest.mono(options)
    end    
end
