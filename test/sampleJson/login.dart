import 'dart:io';

String fixture(String nameOfFile) => File('test/sampleJson/$nameOfFile').readAsStringSync();