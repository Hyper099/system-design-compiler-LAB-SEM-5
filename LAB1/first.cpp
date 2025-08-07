#include <iostream>
#include <fstream>
#include <string>
#include <set>
using namespace std;

int main()
{
    set<string> keyword = {
        "auto", "break", "case", "char", "const", "continue", "default", "do", "double", "else",
        "enum", "extern", "float", "for", "goto", "if", "inline", "int", "long", "register",
        "restrict", "return", "short", "signed", "sizeof", "static", "struct", "switch", "typedef",
        "union", "unsigned", "void", "volatile", "while"
    };
    
    set<char> seperator = {'[', ']', '(', ')', '{', '}', '.', ',', ';'};

    string path = "code.txt";
    ifstream ifile(path);
    if (!ifile.is_open())
    {
        cout << "File path not valid." << endl;
        return 0;
    }

    int keyword_count = 0, identifier_count = 0, operator_count = 0, token_count = 0, seperator_count = 0, other_count = 0;
    string line;
    bool multiLineComment = 0, word = 0, num = 0, singleQuotes = 0, doubleQuotes = 0;
    while (getline(ifile, line))
    {
        string upto;
        for (int i = 0; i < line.size(); i++)
        {
            if (singleQuotes) {
                upto += line[i];
                if (line[i] == '\'') singleQuotes = 0;
                continue;
            }
            if (doubleQuotes) {
                upto += line[i];
                if (line[i] == '\"') doubleQuotes = 0;
                continue;
            }

            if (i > 0 && line[i] == '/' && line[i - 1] == '/') break;

            if (i > 0 && line[i] == '*' && line[i - 1] == '/') {
                upto = "";
                multiLineComment = 1;
            }

            if (multiLineComment) {
                if (i > 0 && line[i] == '/' && line[i - 1] == '*')
                    multiLineComment = 0;
                continue;
            }

            if (!upto.empty()) {
                if (word) {
                    if (line[i] >= 'a' && line[i] <= 'z' || line[i] >= 'A' && line[i] <= 'Z' || line[i] == '_' || line[i] >= '0' && line[i] <= '9') {
                        upto += line[i];
                    }
                    else {
                        if (keyword.count(upto)) {
                            cout << upto << "...keyword" << endl;
                            keyword_count++;
                        }
                        else {
                            cout << upto << "...identifier" << endl;
                            identifier_count++;
                        }
                        upto = "";
                        word = 0;
                    }
                }
                else if (num)
                {
                    if ((line[i] >= '0' && line[i] <= '9') || (line[i] == '.' && i < line.size() && line[i + 1] >= '0' && line[i + 1] <= '9'))
                    {
                        upto += line[i];
                    }
                    else
                    {
                        cout << upto << "...other" << endl;
                        other_count++;
                        upto = "";
                        num = 0;
                    }
                }
                else if (upto[0] == '\'' || upto[0] == '\"')
                {
                    cout << upto << "...other" << endl;
                    other_count++;
                    upto = "";
                }
                else
                {
                    if (line[i] >= 'a' && line[i] <= 'z' || line[i] >= 'A' && line[i] <= 'Z' || line[i] == '_' || line[i] >= '0' && line[i] <= '9' || seperator.count(line[i]) || line[i] == ' ' || line[i] == '\'' || line[i] == '\"')
                    {
                        cout << upto << "...operator" << endl;
                        operator_count++;
                        upto = "";
                    }
                    else
                        upto += line[i];
                }
            }
            if (upto.empty())
            {
                if (line[i] >= 'a' && line[i] <= 'z' || line[i] >= 'A' && line[i] <= 'Z' || line[i] == '_')
                {
                    word = 1;
                    upto = line[i];
                }
                else if ((line[i] >= '0' && line[i] <= '9') || (line[i] == '.' && i < line.size() && line[i + 1] >= '0' && line[i + 1] <= '9'))
                {
                    num = 1;
                    upto = line[i];
                }
                else if (seperator.count(line[i]))
                {
                    cout << line[i] << "...seperator" << endl;
                    seperator_count++;
                }
                else if (line[i] == ' ')
                    continue;
                else
                {
                    if (line[i] == '\'')
                     singleQuotes = 1;
                    else if (line[i] == '\"')
                        doubleQuotes = 1;
                    upto = line[i];
                }
            }
        }
    }
    
    ifile.close();

    cout << endl;
    token_count += keyword_count + operator_count + identifier_count + seperator_count + other_count;
    cout << "Total token count: " << token_count << endl;
    cout << "Total keyword count: " << keyword_count << endl;
    cout << "Total identifier count: " << identifier_count << endl;
    cout << "Total operator count: " << operator_count << endl;
    cout << "Total seperator count: " << seperator_count << endl;
    cout << "Total other count: " << other_count << endl;
    return 0;
}