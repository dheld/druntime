/**
 * TypeInfo support code.
 *
 * Copyright: Copyright Digital Mars 2004 - 2009.
 * License:   <a href="http://www.boost.org/LICENSE_1_0.txt">Boost License 1.0</a>.
 * Authors:   Walter Bright
 */

/*          Copyright Digital Mars 2004 - 2009.
 * Distributed under the Boost Software License, Version 1.0.
 *    (See accompanying file LICENSE or copy at
 *          http://www.boost.org/LICENSE_1_0.txt)
 */
module rt.typeinfo.ti_Areal;

private import rt.typeinfo.ti_real;
private import rt.util.hash;

// real[]

class TypeInfo_Ae : TypeInfo
{
    @trusted:
    const:
    pure:
    nothrow:

    override string toString() const pure nothrow @safe { return "real[]"; }

    override hash_t getHash(in void* p)
    {   real[] s = *cast(real[]*)p;
        return hashOf(s.ptr, s.length * real.sizeof);
    }

    override equals_t equals(in void* p1, in void* p2)
    {
        real[] s1 = *cast(real[]*)p1;
        real[] s2 = *cast(real[]*)p2;
        size_t len = s1.length;

        if (len != s2.length)
            return false;
        for (size_t u = 0; u < len; u++)
        {
            if (!TypeInfo_e._equals(s1[u], s2[u]))
                return false;
        }
        return true;
    }

    override int compare(in void* p1, in void* p2)
    {
        real[] s1 = *cast(real[]*)p1;
        real[] s2 = *cast(real[]*)p2;
        size_t len = s1.length;

        if (s2.length < len)
            len = s2.length;
        for (size_t u = 0; u < len; u++)
        {
            int c = TypeInfo_e._compare(s1[u], s2[u]);
            if (c)
                return c;
        }
        if (s1.length < s2.length)
            return -1;
        else if (s1.length > s2.length)
            return 1;
        return 0;
    }

    @property override size_t tsize() nothrow pure
    {
        return (real[]).sizeof;
    }

    @property override uint flags() nothrow pure
    {
        return 1;
    }

    @property override TypeInfo next() nothrow pure
    {
        return typeid(real);
    }

    @property override size_t talign() nothrow pure
    {
        return (real[]).alignof;
    }

    version (X86_64) override int argTypes(out TypeInfo arg1, out TypeInfo arg2)
    {
        //arg1 = typeid(size_t);
        //arg2 = typeid(void*);
        return 0;
    }
}

// ireal[]

class TypeInfo_Aj : TypeInfo_Ae
{
    @trusted:
    const:
    pure:
    nothrow:

    override string toString() const pure nothrow @safe { return "ireal[]"; }

    @property override TypeInfo next() nothrow pure
    {
        return typeid(ireal);
    }
}
