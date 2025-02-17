## What is DCode?

DCode™ is a FREE forensic utility for converting data found on desktop and mobile devices into human-readable timestamps. It is the most comprehensive tool available for decoding timestamps and is a must-have utility for your tool box.

The software was designed to assist forensic examiners in identifying and decoding timestamp data during a forensic investigation. It will also allow the reverse process where timestamps can be encoded into a number of different formats and data types.
Encoding and Decoding Timestamp Data

## Encoding and Decoding Timestamp Data

DCode™ has support for 69 different timestamp formats from various operating systems and platforms. You can decode values in the form of Little-Endian Hexadecimal, Big-Endian Hexadecimal, 64-bit Integers, 32-bit Integers, Double-precision floating-point numbers and various text formats.

DCode™ also supports time zone translation and will show UTC (Zulu) times and a converted local time based on the selected time zone. If you select the “K” identifier in the timestamp pattern, DCode™ will also display the time zone designator.

## Time Zone Translation

When the Select Time Zone button is clicked, the following window is displayed showing a breakdown of all the parameters for each Time Zone. You can also select the No Adjustment button. This allows each timestamp to be decoded without applying any translation.

## Supported Timestamp Formats

DCode™ can convert the following timestamps into a number of different input and output formats such as Numeric (Int32, Int64, Double-precision floating-point), Hexadecimal (Little-Endian), Hexadecimal (Big-Endian) and Text.

- Apple Absolute Time (Seconds)
- Apple Absolute Time (Nanosecond)
- Apple HFS
- Apple HFS+
- Binary Coded Decimal (BCD) (2-digit Year)
- Binary Coded Decimal (BCD) Extended (4-digit Year)
- Binary Coded Decimal (BCD) Reverse Nibble
- Chromium Time (Microseconds)
- Chromium Time (Milliseconds)
- Chromium Time (Seconds)
- Gmail MIME Boundary
- Google URL EI Parameter
- GPS System Time
- GPS Time
- GSM Time
- Microsoft Ticks
- Motorola Timestamp
- Microsoft FAT MS-DOS (32-bit) Timestamp
- Microsoft FAT MS-DOS (40-bit) Timestamp
- Microsoft MS-DOS (32-bit) wFatDate, wFatTime Timestamp
- Nokia Series 30
- Nokia Series 40
- OLE Automation (64-bit Double)
- Seagate Date Code
- SYSTEMTIME Structure
- Unix Seconds
- Unix Milliseconds
- Unix Microseconds
- UUID (Guid) Timestamp
- Windows Filetime
- Windows Filetime [dwLow:dwHigh]
- Windows Filetime Mime Boundary [dwHigh.dwLow]
- Windows Filetime MSIE Cookie [dwLow,dwHigh]

## Filtering Date Ranges

To quickly identify timestamp values which may be important, DCode™ allows you to set a date range which can be used as a filter your results. To configure a date range, select Tools » Options from the menu and select a From and To Date. Once the date range has been saved, you can activate the filter by selecting Tools » Filter Date Range from the menu (or click Ctrl + R). This will filter your results and will only display values where the date falls between your selected range.
