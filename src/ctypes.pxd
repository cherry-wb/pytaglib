# C++ header definitions needed for the cutags wrapper
from libcpp.list cimport list
from libcpp.utility cimport pair
from libcpp.string cimport string
from libcpp.map cimport map

cdef extern from "taglib/tstring.h" namespace "TagLib::String":
    cdef enum Type:
        Latin1, UTF16, UTF16BE, UTF8, UTF16LE

cdef extern from "taglib/tstring.h" namespace "TagLib":
    cppclass String:
        String(char*, Type)
        String()
        string to8Bit(bool)
        char* toCString(bool)

cdef extern from "taglib/tstringlist.h" namespace "TagLib":
    cppclass StringList:
        list[String].iterator begin()
        list[String].iterator end()
        void append(String&)


cdef extern from "taglib/tag.h" namespace "TagLib":
    cdef cppclass TagDict:
        map[String,StringList].iterator begin()
        map[String,StringList].iterator end()
        StringList& operator[](String&)
        int size()
        void clear()
    
    cdef cppclass Tag:
        TagDict toDict()
        void fromDict(TagDict&)
    
cdef extern from "taglib/audioproperties.h" namespace "TagLib":
    cdef cppclass AudioProperties:
        int length()
        int bitrate()
        int sampleRate()
        int channels()

cdef extern from "taglib/tfile.h" namespace "TagLib":
    cdef cppclass File:
        Tag *tag()
        AudioProperties *audioProperties()
        bint save() except +
        bint isValid()
        
cdef extern from "taglib/fileref.h" namespace "TagLib":
    cdef cppclass FileRef:
        Tag *tag()
        AudioProperties *audioProperties()
        bint save() except +
        FileRef(char* fn) except +
    
cdef extern from "taglib/fileref.h" namespace "TagLib::FileRef":
    cdef File* create(char* fn) except +

ctypedef map[String,StringList].iterator mapiter

ctypedef list[String].iterator listiter