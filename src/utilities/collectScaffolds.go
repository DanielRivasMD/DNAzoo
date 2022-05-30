package main

////////////////////////////////////////////////////////////////////////////////////////////////////

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strconv"
	"strings"
)

////////////////////////////////////////////////////////////////////////////////////////////////////

// declarations
var (
	chrId []string
)

////////////////////////////////////////////////////////////////////////////////////////////////////

func main() {
	fmt.Println("Works")

	// argsWithProg := os.Args
	// argsWithoutProg := os.Args[1:]
	// arg := os.Args[3]

	// open an input file, exit on error
	inputFile, err := os.Open(os.Args[1])
	if err != nil {
		log.Fatal("Error opening input file: ", err)
	}

	// closes file
	defer inputFile.Close()

	// scanner.Scan() advances to the next token returning false if an error was encountered
	scanner := bufio.NewScanner(inputFile)
	for scanner.Scan() {

		fmt.Println(scanner.Text())

		// report if other errors occured io.EOF by scanner.Err().
		if err := scanner.Err(); err != nil {
			log.Fatal(scanner.Err())
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////

// read file & collect sequences
func collectCoordinates(readFile, outFile string) {

	// open an input file, exit on error
	contentFile, err := ioutil.ReadFile(readFile)
	if err != nil {
		log.Fatal("Error opending input file :", err)
	}

	// check whether file exists to avoid appending
	if fileExist(outFile) {
		os.Remove(outFile)
	}

	// mount data string
	dataFasta := strings.NewReader(string(contentFile))

	// fasta.Reader requires a known type template to fill
	// with FASTA data. Here we use *linear.Seq.
	template := linear.NewSeq("", nil, alphabet.DNAredundant)
	readerFasta := fasta.NewReader(dataFasta, template)

	// make a seqio.Scanner to simplify iterating over a
	// stream of data.
	scanFasta := seqio.NewScanner(readerFasta)

	// iterate through each sequence in a multifasta and
	// examine the ID, description and sequence data.
	for scanFasta.Next() {
		// get the current sequence and type assert to *linear.Seq.
		// while this is unnecessary here, it can be useful to have
		// the concrete type.
		sequence := scanFasta.Seq().(*linear.Seq)

		// find scaffold
		if sequence.ID == syncytin.scaffoldIdent {

			// define extraction coordinates
			startI := int64(syncytin.positionIdent.startPos - 1 - hood)
			endI := int64(syncytin.positionIdent.endPos + hood)

			// verify limits
			if startI < 0 {
				startI = 0
			}

			if endI > int64(len(sequence.Seq)) {
				endI = int64(len(sequence.Seq) - 1)
			}

			// determine strand
			strand := ""
			if startCoor == syncytin.positionIdent.startPos {
				strand = "+"
			} else if startCoor == syncytin.positionIdent.endPos {
				strand = "-"
			} else {
				log.Fatal("Strand could not be determined")
			}

			// define record id
			id := syncytin.scaffoldIdent + "_" +
				strconv.FormatFloat(syncytin.positionIdent.startPos, 'f', 0, 64) + "_" +
				strconv.FormatFloat(syncytin.positionIdent.endPos, 'f', 0, 64) + " " +
				species + " " +
				syncytin.scaffoldIdent + " " +
				strconv.FormatInt(startI, 10) + " " +
				strconv.FormatInt(endI, 10) + " " +
				strand

			// find coordinates
			targatSeq := linear.NewSeq(id, sequence.Seq[startI:endI], alphabet.DNA)

			// write candidate
			writeFasta(outFile, targatSeq)
		}
	}

	if err := scanFasta.Error(); err != nil {
		log.Fatal(err)
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////

// write positions
func writeFasta(outFile string, sequence *linear.Seq) {

	// declare io
	f, err := os.OpenFile(outFile, os.O_APPEND|os.O_WRONLY|os.O_CREATE, 0666)

	if err != nil {
		panic(err)
	}

	defer f.Close()

	// declare writer
	w := fasta.NewWriter(f, 10000)

	// writing
	_, err = w.Write(sequence)

	if err != nil {
		panic(err)
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////

// fileExist checks if a file exists and is not a directory before
// try using it to prevent further errors
func fileExist(filename string) bool {
	info, err := os.Stat(filename)
	if os.IsNotExist(err) {
		return false
	}
	return !info.IsDir()
}

////////////////////////////////////////////////////////////////////////////////////////////////////
