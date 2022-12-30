`bulk_extractor` is a high-performance digital forensics exploitation tool.
It is a "get evidence" button that rapidly
scans any kind of input (disk images, files, directories of files, etc)
and extracts structured information such as email addresses, credit card numbers,
JPEGs and JSON snippets without parsing the file
system or file system structures. The results are stored in text files that are easily
inspected, searched, or used as inputs for other forensic processing. bulk_extractor also creates
histograms of certain kinds of features that it finds, such as Google search terms and email addresses,
as previous research has shown that such histograms are especially useful in investigative and law enforcement applications.

Unlike other digital forensics tools, `bulk_extractor` probes every byte of data to see if it is the start of a
sequence that can be decompressed or otherwise decoded. If so, the
decoded data are recursively re-examined. As a result, `bulk_extractor` can find things like BASE64-encoded JPEGs and
compressed JSON objects that traditional carving tools miss.
