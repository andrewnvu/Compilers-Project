#include<iostream>

#include<string>

#include<fstream>

#include<sstream>

#include<algorithm>



using namespace std;



int main()

{



	string filename = "file.txt";

	string newFile = "new_file.txt";

	fstream new_file;

	fstream input_file;

	string line;



	input_file.open(filename.c_str());



	if (!input_file.is_open())

	{

		cout << "Error opening file!";

		return 1;



	}



	while (getline(input_file, line, '\0'))

	{

		while (line.find("(*") != std::string::npos)

		{

			size_t Beg = line.find("(*");

			line.erase(Beg, (line.find("*)", Beg) - Beg) + 2);



		}



		line.erase(std::remove(line.begin(), line.end(), ' '), line.end());

		line.erase(std::remove(line.begin(), line.end(), '\n'), line.end());

		line.erase(std::remove(line.begin(), line.end(), '\t'), line.end());

	}







	for (int i = 0; i < line.length(); i++)

	{



		if (line[i] == ';')

		{

			line.insert(i + 1, "\n");

		}



		if (line[i] == ',')

		{

			line.insert(i + 1, " ");

		}



		if (line[i] == '=')

		{

			line.insert(i + 1, " ");

		}

		if (line[i] == '=')

		{

			line.insert(i++, " ");

		}



		if (line[i] == ':')

		{

			line.insert(i + 1, " ");

		}



		if (line[i] == ':')

		{

			line.insert(i++, " ");

		}



		if (line[i] == '+')

		{

			line.insert(i + 1, " ");

		}



		if (line[i] == '+')

		{

			line.insert(i++, " ");

		}



		if (line[i] == '(')

		{

			line.insert(i + 1, " ");

		}



		if (line[i] == ')')

		{

			line.insert(i++, " ");

		}



	}

	string var = "VAR";

	string begg = "BEGIN";

	string progg = "PROGRAM";



	size_t poss = line.find(var);

	size_t poss2 = line.find(begg);

	size_t poss3 = line.find(progg);



	line.insert(poss + 3, "\n");

	line.insert(poss2 + 6, "\n");

	line.insert(poss3 + 7, " ");



	cout << line;



	input_file.close();



	new_file.open(newFile.c_str(), ios::out);



	if (!new_file.is_open())

	{

		cout << "Error opening file!";

		return 1;



	}



	new_file << line;



	new_file.close();





	//system("PAUSE"); not needed in linux

	return 0;

}
