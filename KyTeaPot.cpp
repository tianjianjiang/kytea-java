#include "KyTeaPot.h"

KyTeaPot::KyTeaPot()
{
    config = new KyteaConfig;
    config->setDebug(0);
    config->setOnTraining(false);

    kytea = new Kytea(config);
    kytea->readModel(config->getModelFile().c_str());
    util = kytea->getStringUtil();
}

KyTeaPot::~KyTeaPot()
{
    delete util;
    delete kytea;
    delete config;
}

vector<WordInfo> *KyTeaPot::getWordInfoVector(string rawSentence)
{
    vector<WordInfo> *word_info_list = new vector<WordInfo>;

    KyteaString surface_string = util->mapString(rawSentence);
    KyteaSentence sentence(surface_string, util->normalize(surface_string));
    kytea->calculateWS(sentence);
    for (size_t i = 0; i < config->getNumTags(); ++i) {
        kytea->calculateTags(sentence, static_cast<int>(i));
    }

    const KyteaSentence::Words &words = sentence.words;
    for (size_t i = 0; i < words.size(); ++i) {
        ScoredTagsVector scored_tags_list;
        for (size_t j = 0; j < words[i].tags.size(); ++j) {
            ScoredTags scored_tags;
            for (size_t k = 0; k < 1; ++k) {
                ScoredTag scored_tag = {util->showString(words[i].tags[j][k].first), words[i].tags[j][k].second};
                scored_tags.push_back(scored_tag);
            }
            scored_tags_list.push_back(scored_tags);
        }
        WordInfo word_info = {util->showString(words[i].surface), scored_tags_list};
        (*word_info_list).push_back(word_info);
    }
    return word_info_list;
}
