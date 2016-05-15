%module KyTeaBag
%include "stl.i"
%include "exception.i"

%{
#include "KyTeaPot.h"
%}

%naturalvar;

%rename(lessThan) operator<;

namespace std {
  %template(StringVector) vector<string>;
  %template(ScoredTags) vector<ScoredTag>;
  %template(ScoredTagsVector) vector< vector<ScoredTag> >;
  %template(WordInfoVector) vector<WordInfo>;
}

%ignore kytea::KyteaWord::setUnknown(bool);
%ignore kytea::KyteaWord::getUnknown() const;

%newobject getWordInfoVector;

%exception{
  try{
    $action
  } catch (const std::exception &e){
    SWIG_exception(SWIG_RuntimeError, e.what() );
  } catch (...) {
    SWIG_exception(SWIG_UnknownError, "Unknown exception");
  }
}

%include kytea/kytea.h
%include kytea/kytea-struct.h
%include KyTeaPot.h
