# Discrete Mathematics 1 Lectures

This repository contains material from lectures on Discrete Mathematics taught at the Warsaw University of Technology (WUT). The core content originates from the official lecture notes and handwritten slides provided by the course instructor. Over time, students have contributed to this repository by committing corrections, clarifications, and additional content to enhance the material.

While much effort has been made to ensure accuracy, these notes may still contain errors. We welcome pull requests with improvements, add-ons, and corrections to help keep the material up-to-date and as error-free as possible.

## Contributing

If you notice any mistakes or have suggestions for additional content, please feel free to:
- Submit a pull request with your corrections or improvements.
- Open an issue to discuss potential enhancements.

Your contributions help making these notes a better resource for everyone studying Discrete Mathematics.

## License

This work is licensed under the [Creative Commons Attribution-NonCommercial 4.0 International License](https://creativecommons.org/licenses/by-nc/4.0/). See the [LICENSE](LICENSE) file for details.

## How to Create a Fork of Our Repository

1. **Fork the Repository:**  
   Click the **Fork** button in the upper right corner on the repository page on GitHub. This will create a copy of the repository under your GitHub account.

2. **Clone Your Fork Locally:**  
   Open your terminal and run the following command (replace `<your-username>` with your GitHub username):

   ```bash
   git clone https://github.com/<your-username>/DM1_MiNICS.git
    ```
### How to Run

Use:
```bash
make
```
or
```bash
make all
```
to compile the project and retain auxiliary files.

Use:
```bash
make delete
```
Build everything, then remove auxiliary files (equivalent to `make all` + `make clean`).

Use:
```bash
make main
```
Compile only the main document into `./output`, retaining auxiliary files.

Use:
```bash
make chapters
```
Compile all chapter `.tex` files into standalone PDFs in `./output/chapters`.

Use:
```bash
make clean
```
Remove intermediate LaTeX build files (`.aux`, `.log`, `.toc`, `.fdb_latexmk`), preserving generated PDFs.

Use:
```bash
make chapters
```
Full cleanup: runs make clean, deletes the main PDF, chapter PDFs, and the entire `./output` directory.