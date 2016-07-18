using System;
using System.IO;
using NUnit.Framework;

namespace SSIS_Integration_Test
{
    [TestFixture]
    public class Test_Load_Customer_Info_Loads_All_Data
    {
        [Test]
        public void When_Valid_Data_Received()
        {
            var testFile = Path.Combine(TestContext.CurrentContext.TestDirectory, $"LoadData-{Guid.NewGuid()}.csv");

            var writer = new FileWriter(testFile);  // <--- YOU  need to write this
            writer.WriteRow("a_known_value");
            writer.WriteRow("a_known_value");
            writer.WriteRow("a_known_value");
            writer.WriteRow("a_known_value");

            var runner = new SSisPackageRunner(); // <--- YOU  need to write this
            runner.Run(Path.Combine(TestContext.CurrentContext.TestDirectory, "PackageUnderTest.dtsx")); // <--- YOU  need to write this
                              //  --------- YOU need to write this
                              //  |
            var tableCount =  //  V  
                        new TableReader().GetCount(
                            "select count(*) from a table where a value is '99' and another value is something like '%fff%'");

            Assert.AreEqual(4, tableCount);
        }
    }
}