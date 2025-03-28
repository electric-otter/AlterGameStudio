# Import Windows Forms for the GUI
cd ..
Add-Type -AssemblyName System.Windows.Forms
Add-Type -TypeDefinition @"
using System;
using System.IO;
using System.Windows.Forms;
using YamlDotNet.Serialization;
using System.Collections.Generic;

public class AssetManager
{
    public static void AddAsset(object sender, EventArgs e)
    {
        OpenFileDialog dialog = new OpenFileDialog();
        dialog.Filter = "Image Files|*.png;*.jpg|All Files|*.*";
        
        if (dialog.ShowDialog() == DialogResult.OK)
        {
            string filePath = dialog.FileName;
            MessageBox.Show("Asset added: " + filePath);
        }
    }

    public static void CreateProject(object sender, EventArgs e)
    {
        string projectPath = "MyGame";
        if (!Directory.Exists(projectPath))
        {
            Directory.CreateDirectory(projectPath);
            MessageBox.Show("Project Created!");
        }
        else
        {
            MessageBox.Show("Project already exists.");
        }
    }

    // Check if dependencies are installed
    public static void CheckDependencies(object sender, EventArgs e)
    {
        string dependenciesFilePath = "\altergamestudioredists\dependencies.yml";
        if (!File.Exists(dependenciesFilePath))
        {
            MessageBox.Show("Dependencies file not found.");
            return;
        }

        var deserializer = new DeserializerBuilder().Build();
        var yaml = File.ReadAllText(dependenciesFilePath);
        var dependencies = deserializer.Deserialize<Dictionary<string, string>>(yaml);

        foreach (var dep in dependencies)
        {
            if (!File.Exists(dep.Value))
            {
                MessageBox.Show("Missing dependency: " + dep.Key + " at " + dep.Value);
                return;
            }
        }

        MessageBox.Show("All dependencies are installed.");
    }

    // Launch Hoppity (Emulator for Hoppity framework)
    public static void LaunchHoppity(object sender, EventArgs e)
    {
        string hoppityPath = "/Hoppity/hoppity.ps1";
        
        if (File.Exists(hoppityPath))
        {
            System.Diagnostics.Process.Start(hoppityPath);
            MessageBox.Show("Hoppity launched.");
        }
        else
        {
            MessageBox.Show("Hoppity launcher not found.");
        }
    }
}
"@

# Creating the main form for Alter Game Studio
$form = New-Object Windows.Forms.Form
$form.Text = "Alter Game Studio"
$form.Size = New-Object Drawing.Size(400, 400)

# Button to create a new project
$newProjectButton = New-Object Windows.Forms.Button
$newProjectButton.Text = "Create New Project"
$newProjectButton.Location = New-Object Drawing.Point(50, 50)
$newProjectButton.Size = New-Object Drawing.Size(150, 40)
$newProjectButton.Add_Click([System.EventHandler]::new([AssetManager]::CreateProject))

# Button to add an asset (image, sound, etc.)
$addAssetButton = New-Object Windows.Forms.Button
$addAssetButton.Text = "Add Asset"
$addAssetButton.Location = New-Object Drawing.Point(50, 120)
$addAssetButton.Size = New-Object Drawing.Size(150, 40)
$addAssetButton.Add_Click([System.EventHandler]::new([AssetManager]::AddAsset))

# Button to check dependencies
$checkDependenciesButton = New-Object Windows.Forms.Button
$checkDependenciesButton.Text = "Check Dependencies"
$checkDependenciesButton.Location = New-Object Drawing.Point(50, 190)
$checkDependenciesButton.Size = New-Object Drawing.Size(150, 40)
$checkDependenciesButton.Add_Click([System.EventHandler]::new([AssetManager]::CheckDependencies))

# Button to launch Hoppity
$launchHoppityButton = New-Object Windows.Forms.Button
$launchHoppityButton.Text = "Launch Hoppity"
$launchHoppityButton.Location = New-Object Drawing.Point(50, 260)
$launchHoppityButton.Size = New-Object Drawing.Size(150, 40)
$launchHoppityButton.Add_Click([System.EventHandler]::new([AssetManager]::LaunchHoppity))

# Text box for console/log output
$consoleOutput = New-Object Windows.Forms.TextBox
$consoleOutput.Multiline = $true
$consoleOutput.Location = New-Object Drawing.Point(50, 310)
$consoleOutput.Size = New-Object Drawing.Size(300, 60)

# Adding controls to the form
$form.Controls.Add($newProjectButton)
$form.Controls.Add($addAssetButton)
$form.Controls.Add($checkDependenciesButton)
$form.Controls.Add($launchHoppityButton)
$form.Controls.Add($consoleOutput)

# Displaying the form
$form.ShowDialog()
