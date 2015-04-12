#!/usr/bin/awk -f

BEGIN {
	FS="\t";
	printf ("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n");
	printf ("    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n");
	printf ("<html xmlns=\"http://www.w3.org/1999/xhtml\">\n");
	printf ("\t<head>\n");
	printf ("\t\t<title>Latest Commits</title>\n");
	printf ("\t<meta>\n");
	printf ("\t<style type=\"text/css\">\n");
	printf ("\t\th1 { font-size: 130%; }\n");
	printf ("\t\th2 { font-size: 110%; }\n");
	printf ("\t\th3 { font-size: 110%; padding-left: 2em; }\n");
	printf ("\t\tspan.t { padding-left: 4em; }\n");
	printf ("\t\tspan.h { font-family: monospace; padding-left: 2em; }\n");
	printf ("\t\tspan.m { font-weight: bold; padding-left: 2em; }\n");
	printf ("\t</style>\n");
	printf ("\t</meta>\n");
	printf ("\t</head>\n");
	printf ("\t<body>\n");
	printf ("\t<h1>Latest Commits</h1>\n")
}

{
	date = substr ($1, 1, 10);
	time = substr ($1, 12, 5);
	repo = $2;
	hash = $3;
	msg  = $4;

	if (date != olddate) {
		olddate = date;
		printf ("\t<h2>%s</h2>\n", date);
	}

	if (repo != oldrepo) {
		oldrepo = repo;
		printf ("\t<h3>%s</h3>\n", repo);
	}

	printf ("\t\t<span class=\"t\">%s</span><span class=\"h\">%s</span><span class=\"m\">%s</span><br />\n", time, hash, msg);
}

END {
	printf ("\t</body>\n");
	printf ("</html>\n");
}


