package Core;

use Exporter 'import';
@EXPORT_OK = qw(get_json);


use Modern::Perl;
use JSON qw(encode_json);
use DBI();


sub get_dbh {
    my $host = 'localhost';
    my $port = 3306;
    my $db = 'mydb';
    my $user = 'root';
    my $pass = '';
    return DBI->connect("DBI:mysql:database=$db;host=$host;port=$port", 
                        $user, $pass);
}


sub do_query {
    my $dbh = get_dbh;
    return unless defined $dbh;
    return $dbh->selectall_arrayref(shift);
}


sub get_json {
    return encode_json do_query shift;
}

