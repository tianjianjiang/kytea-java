#ifndef KYTEAPOT_H
#define KYTEAPOT_H

#include <vector>
#include <string>
#include <kytea/kytea.h>
#include <kytea/kytea-struct.h>
#include <kytea/string-util.h>

using namespace std;
using namespace kytea;

struct ScoredTag
{
    string tag;
    double score;
};

typedef vector<ScoredTag> ScoredTags;

typedef vector<ScoredTags> ScoredTagsVector;

struct WordInfo
{
    string surface;
    ScoredTagsVector tags;
};

class KyTeaPot
{
public:
    KyTeaPot();
    ~KyTeaPot();
    vector<WordInfo> *getWordInfoVector(string rawSentence);

private:
    Kytea *kytea;
    StringUtil *util;
    KyteaConfig *config;
};

#endif
