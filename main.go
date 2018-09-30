package main

import "fmt"

func main() {
	var firstName string = "john"

	//var lastName string
	lastName := "wickss"

	fmt.Printf("hallo %s %s!\n", firstName, lastName)
	fmt.Println("haloo", firstName, lastName + "!")

	name :=  new(string)

	fmt.Println(name)
	fmt.Println(*name)
}