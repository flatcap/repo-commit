#!/usr/bin/awk -f

BEGIN {
	FS="\t";
	printf ("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n");
	printf ("    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n");
	printf ("<html xmlns=\"http://www.w3.org/1999/xhtml\">\n");
	printf ("\t<head>\n");
	printf ("\t\t<title>Latest Commits</title>\n");
	printf ("\t<meta>\n");
	printf ("\t\t<link rel=\"stylesheet\" href=\"list.css\" type=\"text/css\" />\n");
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

	if (length (repo) > 24) {
		repo = substr (repo, 1, 24) "...";
	}

	printf ("\t<div class=\"l\">\n");

	if (date != olddate) {
		olddate = date;
		oldrepo = "";
		printf ("\t\t<div class=\"d\">%s</div>\n", date);
	} else {
		printf ("\t\t<div class=\"d\">&nbsp;</div>\n", date);
	}

	printf ("\t\t<div class=\"t\">%s</div>\n", time);

	if (repo != oldrepo) {
		oldrepo = repo;
		printf ("\t\t<div class=\"r\">%s</div>\n", repo);
	} else {
		printf ("\t\t<div class=\"r\">&nbsp;&nbsp;\"</div>\n", date);
	}

	printf ("\t\t<div class=\"h\">%s</div>\n", hash);
	printf ("\t\t<div class=\"m\">&ldquo;%s&rdquo;</div>\n", msg);
	printf ("\t</div>\n");
}

END {
	printf ("\t</body>\n");
	printf ("</html>\n");
}


