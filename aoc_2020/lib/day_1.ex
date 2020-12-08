defmodule Day1 do
  @moduledoc """
  Documentation for Day1.
  """

  @doc """
  day 1 of AOC:
  Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.

  Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.

  For example, suppose your expense report contained the following:

  1721
  979
  366
  299
  675
  1456
  In this list, the two entries that sum to 2020 are 1721 and 299. Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.

  Of course, your expense report is much larger. Find the two entries that sum to 2020; what do you get if you multiply them together?

  """

  @expense_report [
    1706,
    1466,
    1427,
    1744,
    1684,
    1386,
    2001,
    1750,
    1753,
    1770,
    1559,
    1616,
    1408,
    1860,
    1940,
    2002,
    1862,
    1918,
    1456,
    1209,
    1840,
    1462,
    1783,
    1644,
    1901,
    1791,
    1506,
    2005,
    1338,
    1383,
    1420,
    1631,
    1784,
    1897,
    1771,
    1588,
    1955,
    1937,
    1392,
    1396,
    1803,
    1429,
    1407,
    1698,
    1562,
    1913,
    1678,
    1198,
    1398,
    1703,
    1831,
    1489,
    1782,
    1864,
    1708,
    1397,
    1915,
    1953,
    1395,
    1610,
    1549,
    1564,
    1973,
    1931,
    2009,
    1980,
    1800,
    1443,
    1993,
    1900,
    1964,
    1581,
    1904,
    1665,
    1567,
    1057,
    1805,
    1402,
    1878,
    1729,
    1825,
    1682,
    1719,
    1469,
    1004,
    1591,
    1594,
    811,
    1523,
    1424,
    1756,
    373,
    1442,
    1718,
    1411,
    1892,
    1820,
    1977,
    1871,
    1890,
    1653,
    1372,
    1475,
    1476,
    1422,
    2004,
    1755,
    1676,
    639,
    1425,
    1853,
    1712,
    1525,
    1514,
    1455,
    1658,
    1963,
    1579,
    1861,
    1458,
    1474,
    1613,
    1681,
    1586,
    1441,
    1499,
    1865,
    1735,
    1989,
    1952,
    792,
    1669,
    1509,
    1481,
    1893,
    1445,
    1834,
    1779,
    1732,
    1826,
    1595,
    1829,
    449,
    1920,
    1707,
    1780,
    1935,
    1867,
    1769,
    1107,
    919,
    1382,
    1604,
    1875,
    1453,
    1496,
    1946,
    1659,
    1570,
    1692,
    1630,
    1638,
    1922,
    1691,
    1580,
    1880,
    1482,
    1762,
    1775,
    1376,
    1434,
    1856,
    1971,
    1646,
    1951,
    1416,
    1889,
    1773,
    1814,
    1471,
    1488,
    1736,
    1743,
    1459,
    1389,
    1498,
    1663,
    1611,
    1727,
    1699,
    1624,
    1511,
    1767,
    1754,
    1785,
    1491,
    1235,
    1510,
    1500,
    1485
  ]

  def get_expense_report do
    @expense_report
  end

  def expense_report_entry_sum_equal_2020 do
    # maybe should do this as a Enum.reduce_while
    Enum.each(@expense_report, fn x ->
      Enum.reduce(@expense_report, x, fn
        num, acc ->
          if num + acc == 2020 do
            num && IO.inspect(num * acc)
          else
            acc
          end
      end)
    end)
  end

  def three_expense_report_entries_equal_to_2020 do
    Enum.each(@expense_report, fn x ->
      Enum.reduce(@expense_report, x, fn
        num, acc ->
          remainder = rem(2020, num + acc)

          if Enum.member?(@expense_report, remainder) and remainder != num and remainder != acc do
            num &&
              IO.puts("numbers: #{num}, #{acc}, #{remainder}, product: #{num * acc * remainder}")
          else
            acc
          end
      end)
    end)
  end
end
